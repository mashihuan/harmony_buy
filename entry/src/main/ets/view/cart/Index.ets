import promptAction from '@ohos.promptAction'
import router from '@ohos.router'
import emitter from '@ohos.events.emitter'
import NavigationBar from '../../components/NavigationBar'
import CartModel from '../../model/CartModel'
import GoodsModel from '../../model/GoodsModel'
import CartItem from '../../viewmodel/CartItem'
import GoodsItem from '../../viewmodel/GoodsItem'
import CartEmpty from './Empty'
import CartList from './List'
import CartManage from './Manage'
import CartPay from './Pay'

@Component
export default struct CartIndex {
  @Consume @Watch('onTabIndexChange') currentTabIndex: number
  @State isLogin: boolean = true
  @State isEdit: boolean = false
  @State allGoods: GoodsItem[] = []
  @State @Watch('calcCartInfo') cartList: CartItem[] = []
  @State @Watch('calcCartInfo') selectedIds: number[] = []
  @State totalNumber: number = 0
  @State totalPrice: number = 0

  aboutToAppear() {
    // 创建订单后，删除该商品，重新拉取数据
    emitter.on({ eventId: 3 }, () => {
      this.getCartList()
      this.selectedIds = []
    })
  }

  onTabIndexChange() {
    if (this.currentTabIndex === 3) {
      if (!this.allGoods.length) {
        this.getAllGoods()
      } else {
        this.getCartList()
      }
    } else {
      this.isEdit = false
    }
  }

  async getAllGoods() {
    const res = await GoodsModel.requestAllGoods()
    this.allGoods = res.data?.goods || []
    this.getCartList()
  }

  async getCartList() {
    const cartArr = await CartModel.query()
    const tempArr = []
    if (cartArr && cartArr.length) {
      cartArr.forEach((cart: CartItem) => {
        const goods = this.allGoods.find((goodsItem: GoodsItem) => goodsItem.id === cart.goods_id)
        if (goods) {
          cart.goods = goods
        }
        tempArr.push(new CartItem(cart.id, cart.goods_id, cart.num, cart.goods))
      })
    }
    this.cartList = tempArr
  }

  async changeGoodsNum(cart: CartItem, num: number) {
    return CartModel.update(cart.id, {
      num: cart.num + num
    })
  }

  calcCartInfo() {
    this.totalNumber = 0
    this.totalPrice = 0
    this.selectedIds.forEach(id => {
      const goods = this.cartList.find(goods => goods.id === id)
      if (goods) {
        this.totalNumber += goods.num
        this.totalPrice += goods.num * goods.goods.new_price
      }
    })
  }

  onSubmit() {
    if (!this.selectedIds.length) {
      return promptAction.showToast({ message: '请选择商品' })
    }
    router.pushUrl({
      url: 'pages/OrderPay',
      params: {
        selectedCartList: this.cartList.filter((cart: CartItem) => this.selectedIds.includes(cart.id))
      }
    })
  }

  async onDelete() {
    if (!this.selectedIds.length) {
      return promptAction.showToast({ message: '请选择商品' })
    }
    await CartModel.deleteList(this.selectedIds)
    this.cartList = this.cartList.filter((cart: CartItem) =>!this.selectedIds.includes(cart.id))
    this.selectedIds = []
    promptAction.showToast({ message: '删除成功' })
  }

  build() {
    Column() {
      NavigationBar({ title: '购物车', hiddenBack: true })
      if (this.isLogin) {
        if (this.cartList.length) {
          CartManage({ isEdit: $isEdit })
          CartList({ cartList: $cartList, changeGoodsNum: this.changeGoodsNum.bind(this) })
          CartPay({
            isEdit: $isEdit,
            cartList: $cartList,
            selectedIds: $selectedIds,
            totalNumber: this.totalNumber,
            totalPrice: this.totalPrice,
            onSubmit: this.onSubmit.bind(this),
            onDelete: this.onDelete.bind(this)
          })
        } else {
          CartEmpty({ text: '购物车空空如也,去逛逛吧~' })
        }
      } else {
        Column() {
          CartEmpty({ text: '登录同步购物车商品' })
          Button('登录')
            .backgroundColor($r('app.color.bg_primary'))
        }
      }
    }
    .width('100%')
    .height('100%')
  }
}