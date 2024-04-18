import router from '@ohos.router'
import promptAction from '@ohos.promptAction'
import { Constants } from '../../common/Constants'

class Tip {
  icon: ResourceStr
  text: ResourceStr

  constructor(icon: ResourceStr, text: ResourceStr) {
    this.icon = icon
    this.text = text
  }
}

@Component
export default struct HomeHeader {
  location: string = ''
  tips: Tip[] = [
    new Tip($r('app.media.icon_deliver'), '最快29分钟到达'),
    new Tip($r('app.media.icon_fruit'), '保障新鲜到家'),
    new Tip($r('app.media.icon_refund'), '无理由退换货'),
  ]

  build() {
    Column() {
      Row() {
        Column() {
          Image($r('app.media.icon_location'))
            .width(16)
            .width(16)
            .fillColor('#fff')
          Text('北京市')
            .width(40)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .maxLines(1)
            .fontSize(13)
            .fontColor('#fff')
        }
        .margin({ right: 8 })
        .onClick(() => {
          promptAction.showToast({ message: '点击了定位' })
        })

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
      .width('100%')
      .height(46)
      .alignItems(VerticalAlign.Center)

      Row() {
        ForEach(this.tips, (tip: Tip) => {
          Row() {
            Image(tip.icon)
              .width(16)
              .width(16)
              .margin({ right: 3 })
              .fillColor('#fff')
            Text(tip.text)
              .fontSize(13)
              .fontColor('#fff')
          }
        })
      }
      .width('100%')
      .height(39)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding({ left: Constants.SPACE_16, right: Constants.SPACE_16 })
    .position({ x: 0, y: 0 })
    .zIndex(99)
    .backgroundColor($r('app.color.bg_primary'))
  }
}