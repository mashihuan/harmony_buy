import { BASE_URL } from '../../common/Config'
import { Constants } from '../../common/Constants'
import CartItem from '../../viewmodel/CartItem'

@Component
export default struct OrderGoods {
  @Link cartList: CartItem[]

  build() {
    Column({ space: 12 }) {
      ForEach(this.cartList, (cart: CartItem) => {
        Row() {
          Image(BASE_URL + cart.goods.icon)
            .width(82)
            .height(82)
            .margin({ right: 12 })
          Column() {
            Text(cart.goods.desc)
              .width('100%')
              .maxLines(2)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
              .fontSize(15)
              .fontColor($r('app.color.color_text'))
            Row() {
              Text(`¥${cart.goods.new_price}`)
                .fontSize(15)
                .fontColor($r('app.color.color_new_price'))
              Text(`x${cart.num}`)
                .fontSize(15)
                .fontColor($r('app.color.color_text_tertiary'))
            }
            .width('100%')
            .margin({ top: 12 })
            .justifyContent(FlexAlign.SpaceBetween)
          }
          .layoutWeight(1)
        }
        .width('100%')
      })
    }
    .width('100%')
    .padding({ top: 12, bottom: 12, left: Constants.SPACE_16, right: Constants.SPACE_16 })
    .margin({ bottom: 12 })
    .backgroundColor($r('app.color.color_bg_container'))
  }
}