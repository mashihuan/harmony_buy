import router from '@ohos.router'
import promptAction from '@ohos.promptAction'
import { Constants } from '../common/Constants'
import NavigationBar from '../components/NavigationBar'
import OrderAddress from '../view/orderpay/Address'
import OrderGoods from '../view/orderpay/Goods'
import OrderIntegral from '../view/orderpay/Integral'
import OrderPayMode from '../view/orderpay/PayMode'
import AddressItem from '../viewmodel/AddressItem'
import CartItem from '../viewmodel/CartItem'
import AddressModel from '../model/AddressModel'
import OrderModel, { OrderStatus } from '../model/OrderModel'
import OrderGoodsModel from '../model/OrderGoodsModel'
import CartModel from '../model/CartModel'
import emitter from '@ohos.events.emitter'

@Entry
@Component
struct OrderPay {
  @State @Watch('calcCartInfo') cartList: CartItem[] = []
  @State integral: number = 0
  @State payMode: string = ''
  @State totalNumber: number = 0
  @State totalPrice: number = 0
  @State addressInfo: AddressItem = {
    id: 0,
    name: '',
    phone: '',
    area: '',
    detail: '',
    is_default: false
  }

  onPageShow() {
    const params: any = router.getParams()
    this.cartList = params?.selectedCartList || []

    const addressInfo: AddressItem = AppStorage.Get('addressInfo')
    if(addressInfo) {
      this.addressInfo = { ...addressInfo }
      AppStorage.Delete('addressInfo')
    }else {
      this.getAddressList()
    }
  }

  async getAddressList() {
    const res = await AddressModel.query()
    const data = res || []
    if(data.length) {
      const defaultAddress = data.find((item: AddressItem) => item.is_default)
      if(defaultAddress) {
        this.addressInfo = defaultAddress
      }else {
        this.addressInfo = data[0]
      }
    }
  }

  calcCartInfo() {
    this.totalNumber = 0
    this.totalPrice = 0
    this.cartList.forEach((cart: CartItem) => {
      this.totalNumber += cart.num
      this.totalPrice += cart.num * cart.goods.new_price
    })
  }

  async onSubmit() {
    if(!this.addressInfo.id) {
      return promptAction.showToast({ message: '请选择收货地址' })
    }
    if(!this.payMode) {
      return promptAction.showToast({ message: '请选择支付方式' })
    }
    // 创建order业务表
    const order_id =  await OrderModel.insert({
      address_id: this.addressInfo.id,
      status: OrderStatus.NO_PAY
    })
    // 创建order_goods关系表（存储订单商品信息）
    await OrderGoodsModel.batchInsert(this.cartList.map((cart: CartItem) => {
      return {
        order_id,
        goods_id: cart.goods_id,
        num: cart.num,
        price: (cart.goods.new_price * cart.num).toFixed(2)
      }
    }))
    // 删除确认订单里的购物车
    await CartModel.deleteList(this.cartList.map((cart: CartItem) => cart.id))
    // 发射事件，通知购物车重新拉取请求
    emitter.emit({eventId: 3}, {})
    // 未对接支付，此处直接走失败
    router.replaceUrl({
      url: 'pages/PayResult',
    })
  }

  build() {
    Column() {
      NavigationBar({ title: '确认订单' })
      Column() {
        Scroll() {
          Column() {
            OrderAddress({ addressInfo: $addressInfo })
            OrderGoods({ cartList: $cartList })
            OrderIntegral({ integral: this.integral })
            OrderPayMode({ payMode: $payMode })
          }
          .alignSelf(ItemAlign.Start)
        }
      }
      .layoutWeight(1)
      .margin({ bottom: Constants.SPACE_12 })

      Row({ space: 12 }) {
        Text(`共${this.totalNumber}件`)
          .fontSize(14)
          .fontColor($r('app.color.color_text_tertiary'))
        Text(`合计:`)
          .fontSize(14)
          .fontColor($r('app.color.color_text'))
        Text(`¥${this.totalPrice.toFixed(2)}`)
          .fontSize(14)
          .fontColor($r('app.color.color_new_price'))
        Button('提交订单')
          .height(30)
          .fontSize(13)
          .backgroundColor($r('app.color.bg_primary'))
          .onClick(() => {
            this.onSubmit()
          })
      }
      .width('100%')
      .height(60)
      .padding({ left: Constants.SPACE_16, right: Constants.SPACE_16 })
      .justifyContent(FlexAlign.End)
      .backgroundColor($r('app.color.color_bg_container'))
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.color_bg_layout'))
  }
}