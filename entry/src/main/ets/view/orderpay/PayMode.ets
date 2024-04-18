import { Constants } from '../../common/Constants'

type IMode = 'wechat' | 'ali'

class PayMode {
  name: ResourceStr
  icon: ResourceStr
  mode: IMode
}

@Component
export default struct OrderPayMode {
  @Link payMode: string
  payModes: PayMode[] = [
    { name: '微信支付', icon: $r('app.media.wechat'), mode: 'wechat' },
    { name: '支付宝支付', icon: $r('app.media.ali'), mode: 'ali' },
  ]

  build() {
    Column({ space: 20 }) {
      Text('支付方式')
        .width('100%')
        .fontSize(17)
        .fontColor($r('app.color.color_text'))
      ForEach(this.payModes, (payMode: PayMode) => {
        Row() {
          Image(payMode.icon)
            .width(33)
            .height(33)
            .margin({ right: 16 })
          Text(payMode.name)
            .fontColor($r('app.color.color_text'))
          Blank()
          Radio({ group: 'pay', value: payMode.mode })
            .onChange((isChecked) => {
              if (isChecked) {
                this.payMode = payMode.mode
              }
            })
        }
        .width('100%')
      })
    }
    .width('100%')
    .padding({ top: 12, bottom: 12, left: Constants.SPACE_16, right: Constants.SPACE_16 })
    .margin({ bottom: 12 })
    .backgroundColor($r('app.color.color_bg_container'))
  }
}