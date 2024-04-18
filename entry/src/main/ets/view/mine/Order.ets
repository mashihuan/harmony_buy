import router from '@ohos.router'
import { Constants } from '../../common/Constants'

@Extend(Text) function grayText() {
  .fontColor('#999')
  .fontSize(14)
}

class OrderType {
  icon: ResourceStr
  text: ResourceStr
  path: string
  type?: string
  params?: {
    index: number
  }
}

@Component
export default struct MineOrder {
  orderTypes: OrderType[] = [
    { text: '待付款', icon: $r('app.media.order_no_pay'), path: 'pages/Order', params: { index: 1 } },
    { text: '待收货', icon: $r('app.media.order_no_delivery'), path: 'pages/Order', params: { index: 2 } },
    { text: '待评价', icon: $r('app.media.order_no_comment'), path: 'pages/Order', params: { index: 3 } },
    { text: '售后/退款', icon: $r('app.media.order_after_sale'), path: 'pages/AfterSale', params: { index: 0 } },
  ]

  build() {
    Column() {
      Row() {
        Text('我的订单')
          .fontColor($r('app.color.color_text'))
        Blank()
        Text('查看更多订单')
          .grayText()
        Image($r('app.media.arrow_right'))
          .width(16)
          .height(16)
          .fillColor('#999')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .onClick(() => {
        router.pushUrl({
          url: 'pages/Order',
          params: { index: 0 }
        })
      })

      Row() {
        ForEach(this.orderTypes, (orderType: OrderType) => {
          Column() {
            Image(orderType.icon)
              .width(24)
              .height(22)
              .margin({ bottom: Constants.SPACE_12 })
            Text(orderType.text)
              .grayText()
          }
          .width('25%')
          .height(72)
          .justifyContent(FlexAlign.End)
          .onClick(() => {
            router.pushUrl({
              url: orderType.path,
              params:  orderType.params,
            })
          })
        })
      }
    }
    .width('100%')
    .padding(Constants.SPACE_12)
    .backgroundColor($r('app.color.color_bg_container'))
    .borderRadius(5)
  }
}