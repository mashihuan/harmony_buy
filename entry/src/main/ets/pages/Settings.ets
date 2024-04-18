import router from '@ohos.router'
import promptAction from '@ohos.promptAction'
import { Constants } from '../common/Constants'
import Loading from '../components/Loading'
import NavigationBar from '../components/NavigationBar'

@Extend(Row) function rowStyle() {
  .width('100%')
  .height(66)
  .padding({ left: Constants.SPACE_12, right: Constants.SPACE_12 })
  .border({ width: { bottom: 1 }, color: $r('app.color.color_border_secondary'), style: BorderStyle.Solid })
}

@Extend(Text) function textStyle() {
  .fontColor($r('app.color.color_text'))
}

@CustomDialog
struct ExitDialog {
  controller: CustomDialogController
  confirm: () => void

  build() {
    Column() {
      Text('提示')
      Text('确定要退出登录吗？')
        .padding(30)
      Column({space: 10}) {
        Button('确定')
          .width('100%')
          .backgroundColor($r('app.color.bg_primary'))
          .onClick(() => {
            this.confirm()
            this.controller.close()
          })
        Button('取消')
          .width('100%')
          .backgroundColor(Color.Transparent)
          .border({width: 1, style: BorderStyle.Solid, color: $r('app.color.color_border_secondary')})
          .fontColor($r('app.color.color_text'))
          .onClick(() => {
            this.controller.close()
          })
      }
      .width('100%')
    }
    .width('100%')
    .padding(Constants.SPACE_16)
  }
}

@Entry
@Component
struct Settings {
  exitController: CustomDialogController = new CustomDialogController({
    builder: ExitDialog({
      confirm: () => {
        router.pushUrl({
          url: 'pages/Login'
        })
      }
    })
  })
  loadingController: CustomDialogController = new CustomDialogController({
    builder: Loading({}),
    autoCancel: false,
    customStyle: true,
    offset: { dx: 0, dy: 44 },
    // maskColor: Color.Transparent
  })

  build() {
    Column() {
      NavigationBar({ title: '设置' })
      Column() {
        Row() {
          Text('检查更新')
            .textStyle()
        }
        .rowStyle()
        .onClick(() => {
          this.loadingController.open()
          setTimeout(() => {
            this.loadingController.close()
            promptAction.showToast({ message: '当前已是最新版本！' })
          }, 2000)
        })

        Row() {
          Text('退出登录')
            .textStyle()
        }
        .rowStyle()
        .onClick(() => {
          this.exitController.open()
        })
      }
      .width('100%')
      .padding({ left: Constants.SPACE_16, right: Constants.SPACE_16 })
      .backgroundColor($r('app.color.color_bg_container'))
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.color_bg_layout'))
  }
}