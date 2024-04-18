import router from '@ohos.router'
import NavigationBar from '../components/NavigationBar'
import { OrderStatus } from '../model/OrderModel'

@Entry
@Component
struct PayResult {
  build() {
    Column() {
      NavigationBar({ title: '支付结果' })
      Column() {
        Image($r('app.media.round_close'))
          .width(100)
          .height(100)
          .fillColor('#ff0000')
        Text('支付失败')
          .margin({ top: 10 })

        Button('确定')
          .width('100%')
          .margin({ top: 100 })
          .backgroundColor($r('app.color.bg_primary'))
          .onClick(() => {
            router.replaceUrl({
              url: 'pages/Order',
              params: {
                status: OrderStatus.NO_PAY
              }
            })
          })
      }
      .width('100%')
      .padding({ top: 75, right: 50, bottom: 0, left: 50 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.color_bg_layout'))
  }
}