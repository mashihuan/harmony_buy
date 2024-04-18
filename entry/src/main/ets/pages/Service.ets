import promptAction from '@ohos.promptAction'
import NavigationBar from '../components/NavigationBar'

@Extend(Image) function ImageStyle() {
  .width(93)
  .height(99)
  .margin({ bottom: 16 })
}

@Extend(Text) function textStyle() {
  .fontColor($r('app.color.color_text'))
}

@Entry
@Component
struct Service {
  build() {
    Column() {
      NavigationBar({ title: '联系客服' })
      Row() {
        Column() {
          Image($r('app.media.service_qq'))
            .ImageStyle()
          Text('客服QQ')
            .textStyle()
        }
        .width('50%')
        .onClick(() => {
          promptAction.showToast({ message: '点击了客服QQ' })
        })

        Column() {
          Image($r('app.media.service_phone'))
            .ImageStyle()
          Text('客服电话')
            .textStyle()
        }
        .width('50%')
        .onClick(() => {
          promptAction.showToast({ message: '点击了客服电话' })
        })
      }
      .width('100%')
      .margin({ top: 80 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.color_bg_layout'))
  }
}