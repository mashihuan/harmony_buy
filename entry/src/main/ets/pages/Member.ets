import promptAction from '@ohos.promptAction'
import { Constants } from '../common/Constants'
import NavigationBar from '../components/NavigationBar'

class PrivilegeItem {
  icon: ResourceStr
  text: ResourceStr
}

class MemberItem {
  name: ResourceStr
  days: number
  price: number
}

type IMode = 'wechat' | 'ali'

class PayMode {
  name: ResourceStr
  icon: ResourceStr
  mode: IMode
}

@Entry
@Component
struct Member {
  @State currentMemberIndex: number = 0
  @State payMode: string = ''
  privileges: PrivilegeItem[] = [
    { text: '特价', icon: $r('app.media.member_price') },
    { text: '两倍积分', icon: $r('app.media.member_integral') }
  ]
  members: MemberItem[] = [
    { name: '青铜会员', days: 30, price: 10 },
    { name: '黄金会员', days: 90, price: 25 },
    { name: '钻石会员', days: 180, price: 50 },
  ]
  payModes: PayMode[] = [
    { name: '微信支付', icon: $r('app.media.wechat'), mode: 'wechat' },
    { name: '支付宝支付', icon: $r('app.media.ali'), mode: 'ali' },
  ]

  build() {
    Column() {
      NavigationBar({ title: '大会员' })
      Column() {
        Row() {
          ForEach(this.privileges, (privilege: PrivilegeItem) => {
            Column() {
              Image(privilege.icon)
                .width(44)
                .height(44)
                .margin({ bottom: Constants.SPACE_16 })
                .borderRadius(22)
              Text(privilege.text)
                .fontColor($r('app.color.color_text'))
            }
          })
        }
        .width('100%')
        .margin({ top: 27, bottom: 27 })
        .justifyContent(FlexAlign.SpaceAround)

        Column() {
          ForEach(this.members, (member: MemberItem, index: number) => {
            Row() {
              Text(member.name)
                .margin({ right: Constants.SPACE_12 })
                .fontColor($r('app.color.color_text'))
              Text(member.days + '天')
                .fontColor($r('app.color.color_text'))
              Blank()
              Text('¥' + member.price.toFixed(0))
                .fontColor($r('app.color.color_new_price'))
            }
            .width('100%')
            .padding(Constants.SPACE_16)
            .backgroundColor(this.currentMemberIndex === index ? $r('app.color.color_primary_light') : '')
            .border({ width: { bottom: 1 }, style: BorderStyle.Solid, color: $r('app.color.color_border') })
            .onClick(() => this.currentMemberIndex = index)
          })
        }
        .width('100%')
        .border({ width: { top: 1, right: 1, left: 1 }, style: BorderStyle.Solid, color: $r('app.color.color_border') })

        Column() {
          Text('支付方式')
            .width('100%')
            .margin({ bottom: 27 })
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
              Radio({group: 'pay', value: payMode.mode})
                .onChange((isChecked) => {
                  if(isChecked) {
                    this.payMode = payMode.mode
                  }
                })
            }
            .width('100%')
            .margin({ bottom: 22 })
          })
        }
        .width('100%')
        .margin({ top: 32 })

        Button('立即开通')
          .width('100%')
          .margin({top: 60})
          .backgroundColor($r('app.color.bg_primary'))
          .onClick(() => {
            const currentPay = this.payModes.find((payMode: PayMode) => payMode.mode === this.payMode)
            if(!currentPay) {
              promptAction.showToast({message: '请选择支付方式'})
            }else {
              promptAction.showToast({message: currentPay.name})
            }
          })
      }
      .width('100%')
      .padding(Constants.SPACE_16)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#fff')
  }
}