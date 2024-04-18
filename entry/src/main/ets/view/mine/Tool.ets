import router from '@ohos.router'
import { Constants } from '../../common/Constants'

@Extend(Text) function grayText() {
  .fontColor('#999')
  .fontSize(14)
}

class ToolType {
  icon: ResourceStr
  text: ResourceStr
  path: string
  type?: string
}


@Component
export default struct MineTool {
  toolTypes: ToolType[] = [
    { text: '会员卡', icon: $r('app.media.tool_member'), path: 'pages/Member' },
    { text: '收货地址', icon: $r('app.media.tool_address'), path: 'pages/Address' },
    { text: '邀请有礼', icon: $r('app.media.tool_invite'), path: 'pages/Invite' },
    { text: '联系客服', icon: $r('app.media.tool_service'), path: 'pages/Service' },
    { text: '意见反馈', icon: $r('app.media.tool_feedback'), path: 'pages/Feedback' },
    { text: '设置', icon: $r('app.media.tool_settings'), path: 'pages/Settings' },
  ]

  build() {
    Column() {
      Row() {
        Text('工具与服务')
          .fontColor($r('app.color.color_text'))
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      Flex({ wrap: FlexWrap.Wrap }) {
        ForEach(this.toolTypes, (toolType: ToolType) => {
          Column() {
            Image(toolType.icon)
              .width(24)
              .height(22)
              .margin({ bottom: Constants.SPACE_12 })
            Text(toolType.text)
              .grayText()
          }
          .width('25%')
          .height(72)
          .justifyContent(FlexAlign.End)
          .onClick(() => {
            router.pushUrl({ url: toolType.path })
          })
        })
      }
    }
    .width('100%')
    .padding(Constants.SPACE_12)
    .backgroundColor($r('app.color.color_bg_container'))
    .borderRadius(5)
  }
}