import router from '@ohos.router'
import { Constants } from '../../common/Constants'
import AddressItem from '../../viewmodel/AddressItem'

@Component
export default struct OrderAddress {
  @Link addressInfo: AddressItem

  build() {
    Column() {
      Row() {
        if (this.addressInfo.id) {
          Column() {
            Row() {
              Text(this.addressInfo.name)
                .margin({ right: 12 })
                .fontSize(17)
                .fontWeight(700)
                .fontColor($r('app.color.color_text'))
              Text(this.addressInfo.phone)
                .fontSize(17)
                .fontWeight(700)
                .fontColor($r('app.color.color_text'))
            }

            Row() {
              Text(this.addressInfo.area)
                .margin({ right: 5 })
                .fontSize(15)
                .fontColor($r('app.color.color_text_tertiary'))
              Text(this.addressInfo.detail)
                .fontSize(15)
                .fontColor($r('app.color.color_text_tertiary'))
                .maxLines(1)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
            }
            .margin({ top: 8 })
          }
          .layoutWeight(1)
          .alignItems(HorizontalAlign.Start)
        } else {
          Row() {
            Image($r('app.media.icon_add'))
              .width(22)
              .height(22)
              .margin({ right: 10 })
            Text('添加收货地址')
              .fontSize(14)
              .fontColor($r('app.color.color_text_secondary'))
          }
          .layoutWeight(1)
        }

        Image($r('app.media.arrow_right'))
          .width(16)
          .height(16)
          .fillColor($r('app.color.color_text_tertiary'))
      }
      .width('100%')
      .padding({ top: 12, bottom: 12, right: Constants.SPACE_16, left: Constants.SPACE_16 })
      .backgroundColor($r('app.color.color_bg_container'))

      Image($r('app.media.icon_border'))
        .width('100%')
        .height(2)
    }
    .width('100%')
    .margin({ bottom: 12 })
    .onClick(() => {
      router.pushUrl({
        url: 'pages/Address',
        params: {
          from: 'pages/OrderPay'
        }
      })
    })
  }
}