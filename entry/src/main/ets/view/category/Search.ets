import router from '@ohos.router'
import { Constants } from '../../common/Constants'

@Component
export default struct CategorySearch {
  build() {
    Row() {
      Row() {
        Image($r('app.media.icon_search'))
          .width(18)
          .margin({ right: 5 })
        Text('请输入')
          .fontColor($r('app.color.color_text_tertiary'))
      }
      .layoutWeight(1)
      .height(28)
      .padding({ left: 16, right: 16 })
      .backgroundColor($r('app.color.color_bg_container'))
      .borderRadius(14)
      .onClick(() => {
        router.pushUrl({
          url: 'pages/SearchPage'
        })
      })
    }
    .height(44)
    .padding({left: Constants.SPACE_16, right: Constants.SPACE_16})
    .position({x: 0, y: 0})
    .zIndex(99)
    .backgroundColor($r('app.color.bg_primary'))
  }
}