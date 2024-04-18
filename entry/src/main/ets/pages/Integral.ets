import promptAction from '@ohos.promptAction'
import { Constants } from '../common/Constants'
import NavigationBar from '../components/NavigationBar'

@Extend(Button) function buttonStyle() {
  .type(ButtonType.Normal)
  .height(32)
  .borderRadius(5)
  .backgroundColor('')
  .border({ width: 1, style: BorderStyle.Solid, color: '#eee' })
}

@Entry
@Component
struct Integral {
  @State integral: number = 3
  @State isSignIn: boolean = false

  build() {
    Column() {
      NavigationBar({ title: '积分' })
      Column() {
        Text('我的积分')
          .fontColor('#fff')
        Text(this.integral.toString())
          .margin({ top: 44 })
          .fontColor('#fff')
          .fontSize(40)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
      .height(160)
      .alignItems(HorizontalAlign.Start)
      .padding({ top: Constants.SPACE_12, left: Constants.SPACE_16, right: Constants.SPACE_16 })
      .backgroundColor($r('app.color.bg_primary'))

      Row() {
        if (!this.isSignIn) {
          Button('签到')
            .buttonStyle()
            .onClick(() => {
              // 模拟签到，具体业务自行实现
              this.integral += 1
              this.isSignIn = true
              promptAction.showToast({ message: '签到成功' })
            })
        } else {
          Button('已签到')
            .buttonStyle()
            .enabled(false)
            .opacity(0.4)
        }
      }
      .width('100%')
      .height(44)
      .justifyContent(FlexAlign.End)
      .backgroundColor('#48b236')
      .padding({ left: Constants.SPACE_16, right: Constants.SPACE_16 })
    }
    .width('100%')
    .height('100%')
  }
}