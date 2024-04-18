import router from '@ohos.router'
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

@Entry
@Component
struct Login {
  @State phone: string = ''
  @State password: string = ''

  build() {
    Column() {
      NavigationBar({ title: '登录', hiddenBack: true })
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
          Image($r('app.media.icon_lock'))
            .width(25)
          TextInput({ text: this.password, placeholder: '请输入密码' })
            .inputStyle()
            .type(InputType.Password)
            .onChange(val => this.password = val)
        }
        .rowStyle()

        Row() {
          Text('立即注册')
            .fontColor($r('app.color.color_text_secondary'))
            .onClick(() => router.pushUrl({ url: 'pages/Register' }))
          Text('忘记密码')
            .fontColor($r('app.color.color_text_secondary'))
            .onClick(() => router.pushUrl({ url: 'pages/ForgetPassword' }))
        }
        .width('100%')
        .margin({ top: 27 })
        .justifyContent(FlexAlign.SpaceBetween)

        Button('立即登录')
          .width('100%')
          .margin({ top: 120 })
          .backgroundColor($r('app.color.bg_primary'))
          .onClick(() => {
            router.replaceUrl({
              url: 'pages/Index'
            })
          })

        Column() {
          Image($r('app.media.login_wechat'))
            .width(55)
            .height(55)
            .margin({ bottom: 12 })
            .borderRadius(30)
          Text('微信登录')
            .fontColor($r('app.color.color_text_secondary'))
        }
        .width('100%')
        .position({ y: '80%' })
        .onClick(() => {
          promptAction.showToast({ message: '点击了微信登录' })
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