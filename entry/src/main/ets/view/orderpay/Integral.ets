import promptAction from '@ohos.promptAction'
import { Constants } from '../../common/Constants'

@Component
export default struct OrderIntegral {
  @Prop integral: number

  build() {
    Column() {
      Row() {
        Text(`可用积分（${0}）`)
          .fontSize(14)
          .fontColor($r('app.color.color_text'))
        Image($r('app.media.icon_question'))
          .width(15)
          .height(16)
          .onClick(() => promptAction.showToast({ message: '积分满100可用' }))
        Blank()
        Checkbox()
          .selectedColor($r('app.color.color_primary'))
          .enabled(this.integral >= 100)
        Text('使用')
          .fontSize(14)
          .fontColor($r('app.color.color_text'))
      }
      .width('100%')

      Text('备注')
        .width('100%')
        .margin({ top: 10, bottom: 10 })
        .fontSize(14)
        .fontColor($r('app.color.color_text'))
      TextArea({ placeholder: '有什么需要告诉我们的' })
        .height(58)
        .borderRadius(0)
        .fontSize(14)
    }
    .width('100%')
    .padding({ top: 12, bottom: 12, left: Constants.SPACE_16, right: Constants.SPACE_16 })
    .margin({ bottom: 12 })
    .backgroundColor($r('app.color.color_bg_container'))
  }
}