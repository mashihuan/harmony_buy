import router from '@ohos.router'
import { Constants } from '../../common/Constants'

@Styles function boxStyle() {
  .width('50%')
  .padding({
    left: Constants.SPACE_12,
    right: Constants.SPACE_12,
    top: Constants.SPACE_16,
    bottom: Constants.SPACE_16
  })
}

@Extend(Image) function imageStyle() {
  .width(27)
  .height(27)
  .margin({ right: Constants.SPACE_12 })
}

@Extend(Text) function textStyle() {
  .fontSize(14)
}

@Component
export default struct MineCoupon {
  build() {
    Row() {
      Row() {
        Image($r('app.media.mine_coupon'))
          .imageStyle()
        Text('优惠券')
          .textStyle()
        Blank()
        Text('0张')
          .textStyle()
      }
      .boxStyle()
      .border({ width: { right: 1 }, style: BorderStyle.Solid, color: '#eee' })
      .onClick(() => router.pushUrl({ url: 'pages/Coupon' }))

      Row() {
        Image($r('app.media.mine_integral'))
          .imageStyle()
        Text('积分')
          .textStyle()
        Blank()
        Text('3分')
          .textStyle()
      }
      .boxStyle()
      .onClick(() => router.pushUrl({ url: 'pages/Integral' }))
    }
    .width('100%')
    .margin({ top: -35 })
    .backgroundColor($r('app.color.color_bg_container'))
    .borderRadius(5)
  }
}