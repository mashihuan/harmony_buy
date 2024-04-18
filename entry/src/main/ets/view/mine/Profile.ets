import router from '@ohos.router'
import { Constants } from '../../common/Constants'

@Component
export default struct MineProfile {
  build() {
    Row() {
      Image($r('app.media.avatar'))
        .width(66)
        .height(66)
        .borderRadius(33)
        .margin({ right: Constants.SPACE_12 })
      Column() {
        Text('食屎不忘拉屎人')
          .margin({ bottom: 8 })
          .fontSize(18)
          .fontColor('#fff')
        Row() {
          Image($r('app.media.icon_settings'))
            .width(16)
            .height(16)
            .margin({ right: 5 })
          Text('个人资料')
            .fontSize(14)
            .fontColor('#fff')
        }
        .opacity(0.8)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height(140)
    .padding(Constants.SPACE_16)
    .alignItems(VerticalAlign.Top)
    .backgroundColor($r('app.color.bg_primary'))
    .onClick(() => router.pushUrl({ url: 'pages/PersonalData' }))
  }
}