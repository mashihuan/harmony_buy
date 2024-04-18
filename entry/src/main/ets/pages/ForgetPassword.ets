import promptAction from '@ohos.promptAction'
import { Constants } from '../common/Constants'
import NavigationBar from '../components/NavigationBar'

@Extend(Row) function rowStyle() {
  .width('100%')
  .padding(Constants.SPACE_16)
  .margin({ top: 16 })
  .border({ width: { bottom: 1 }, style: BorderStyle.Solid, color: $r('app.color.color_border') })
}

@Styles function pressedStyles() {
  .backgroundColor('#fff')
}

@Extend(TextInput) function inputStyle() {
  .padding({ bottom: 0, top: 0 })
  .layoutWeight(1)
  .backgroundColor('#fff')
  .stateStyles({
    pressed: pressedStyles,
  })
}

const SECURITY_MSG = '获取验证码'
const SECURITY_COUNTER = 60

@Entry
@Component
struct ForgetPassword {
  @State phone: string = ''
  @State security: string = ''
  @State securityMsg: string = SECURITY_MSG
  @State securityCounter: number = SECURITY_COUNTER
  @State password: string = ''
  @State password2: string = ''
  timer: number = -1

  aboutToDisappear() {
    if (this.timer > -1) {
      clearInterval(this.timer)
    }
  }

  getSecurityCode() {
    if (!this.phone) {
      return promptAction.showToast({ message: '请输入手机号' })
    }
    if (this.timer > -1) {
      clearInterval(this.timer)
    }
    this.timer = setInterval(() => {
      if (this.securityCounter <= 1) {
        this.securityMsg = SECURITY_MSG
        this.securityCounter = SECURITY_COUNTER
        return clearInterval(this.timer)
      }
      this.securityCounter -= 1
      this.securityMsg = `${this.securityCounter}S后重新获取`
    }, 1000)
  }

  build() {
    Column() {
      NavigationBar({ title: '忘记密码' })
      Column() {
        Row() {
          Image($r('app.media.icon_mobile'))
            .width(25)
          TextInput({ text: this.phone, placeholder: '请输入手机号' })
            .inputStyle()
            .type(InputType.PhoneNumber)
            .onChange(val => this.phone = val)
        }
        .rowStyle()

        Row() {
          Image($r('app.media.icon_security'))
            .width(25)
          TextInput({ text: this.security, placeholder: '请输入验证码' })
            .inputStyle()
            .onChange(val => this.security = val)
          Button(this.securityMsg)
            .enabled(this.securityCounter === SECURITY_COUNTER)
            .height(30)
            .backgroundColor(Color.Transparent)
            .fontColor($r('app.color.color_primary'))
            .fontSize(13)
            .onClick(() => this.getSecurityCode())
        }
        .rowStyle()

        Row() {
          Image($r('app.media.icon_lock'))
            .width(25)
          TextInput({ text: this.password, placeholder: '请输入密码' })
            .inputStyle()
            .type(InputType.Password)
            .onChange(val => this.password = val)
        }
        .rowStyle()

        Row() {
          Image($r('app.media.icon_lock'))
            .width(25)
          TextInput({ text: this.password2, placeholder: '请确认密码' })
            .inputStyle()
            .type(InputType.Password)
            .onChange(val => this.password2 = val)
        }
        .rowStyle()

        Button('确定修改')
          .width('100%')
          .margin({ top: 120 })
          .backgroundColor($r('app.color.bg_primary'))
          .onClick(() => {
            promptAction.showToast({ message: '点击了修改' })
          })
      }
      .width('100%')
      .padding({ left: Constants.SPACE_16, right: Constants.SPACE_16 })
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.color_bg_container'))
  }
}