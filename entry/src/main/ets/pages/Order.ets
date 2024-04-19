import router from '@ohos.router'
import NavigationBar from '../components/NavigationBar'
import GoodsModel from '../model/GoodsModel'
import OrderGoodsModel from '../model/OrderGoodsModel'
import OrderModel from '../model/OrderModel'
import OrderIndex from '../view/order/Index'
import GoodsItem from '../viewmodel/GoodsItem'
import OrderGoodsItem from '../viewmodel/OrderGoodsItem'
import OrderItem from '../viewmodel/OrderItem'

@Entry
@Component
struct Order {
  @State @Watch('getOrderList') currentTabIndex: number = 0
  @State orderList: OrderItem[] = []
  @State allGoods: GoodsItem[] = []

  aboutToAppear() {
    const params = router.getParams() as any
    this.currentTabIndex = params.index || params.status || 0
  }

  async getOrderList() {
    const res = await GoodsModel.requestAllGoods()
    this.allGoods = res.data?.goods || []
    const orderGoods = await OrderGoodsModel.query()
    const orderList = await OrderModel.queryByStatus(this.currentTabIndex)
    orderList.forEach((order: OrderItem) => {
      const targetOrderGoodsList: OrderGoodsItem[] = orderGoods.filter((orderGoods: OrderGoodsItem) => orderGoods.order_id === order.id)
      const goods: OrderGoodsItem[] = []
      let total_num = 0
      let price = 0
      targetOrderGoodsList.forEach((orderGoods: OrderGoodsItem) => {
        const targetGoods = this.allGoods.find((goods: GoodsItem) => goods.id === orderGoods.goods_id)
        if (targetGoods) {
          goods.push({ goods: targetGoods, ...orderGoods })
          total_num += orderGoods.num
          price += orderGoods.price
        }
      })
      order.goods = goods
      order.total_num = total_num
      order.price = price
    })
    this.orderList = orderList
  }

  build() {
    Column() {
      NavigationBar({ title: '我的订单' })
      Tabs({ index: this.currentTabIndex }) {
        TabContent() {
          Column() {
            OrderIndex({ orderList: $orderList })
          }
          .width('100%')
          .height('100%')
        }
        .tabBar(this.TabBuilder('全部', 0))

        TabContent() {
          Column() {
            OrderIndex({ orderList: $orderList })
          }
          .width('100%')
          .height('100%')
        }
        .tabBar(this.TabBuilder('待付款', 1))

        TabContent() {
          Column() {
            OrderIndex({ orderList: $orderList })
          }
          .width('100%')
          .height('100%')
        }
        .tabBar(this.TabBuilder('待收货', 2))

        TabContent() {
          Column() {
            OrderIndex({ orderList: $orderList })
          }
          .width('100%')
          .height('100%')
        }
        .tabBar(this.TabBuilder('待评价', 3))
      }
      .onChange((index) => {
        this.currentTabIndex = index
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.color_bg_layout'))
  }

  @Builder TabBuilder(text: ResourceStr, index: number) {
    Row() {
      if (this.currentTabIndex === index) {
        Text(text)
          .height('100%')
          .fontColor($r('app.color.color_primary'))
          .border({ width: { bottom: 2 }, style: BorderStyle.Solid, color: $r('app.color.color_primary') })
      } else {
        Text(text)
          .fontColor($r('app.color.color_text_tertiary'))
      }
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .backgroundColor($r('app.color.color_bg_container'))
    .border({ width: { bottom: 1 }, style: BorderStyle.Solid, color: $r('app.color.color_border_secondary') })
  }
}