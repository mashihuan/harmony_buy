import promptAction from '@ohos.promptAction'
import NavigationBar from '../components/NavigationBar'

@Entry
@Component
struct Invite {
  build() {
    Column() {
      NavigationBar({ title: '邀请有礼' })
      Image($r('app.media.invite_banner'))
        .width('100%')

      Button('立即邀请微信好友')
        .width('90%')
        .position({x: '5%', y: '90%'})
        .backgroundColor($r('app.color.bg_primary'))
        .onClick(() => {
          promptAction.showToast({ message: '点击了邀请' })
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.color_bg_layout'))
  }
}