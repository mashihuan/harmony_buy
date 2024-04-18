import promptAction from '@ohos.promptAction'
import { BASE_URL } from '../../common/Config'
import { Constants } from '../../common/Constants'
import CartItem from '../../viewmodel/CartItem'

@Component
export default struct CartListItem {
  @ObjectLink cart: CartItem
  changeGoodsNum: (cart: CartItem, num: number) => Promise<void>

  build() {
    Row() {
      Checkbox({group: 'cart', name: this.cart.id.toString()})
        .selectedColor($r('app.color.color_primary'))
      Image(BASE_URL + this.cart.goods.icon)
        .width(100)
        .height(100)
        .margin({ left: Constants.SPACE_12, right: Constants.SPACE_12 })
      Column() {
        Text(this.cart.goods.name)
          .fontSize(14)
        Row() {
          Text('¥' + this.cart.goods.new_price.toFixed(1))
            .fontColor($r('app.color.color_new_price'))
            .fontSize(14)
          Counter() {
            Text(this.cart.num.toString())
          }
          .onInc(async () => {
            await this.changeGoodsNum(this.cart, 1)
            this.cart.num += 1
          })
          .onDec(async () => {
            if(this.cart.num <= 1) {
              return promptAction.showToast({message: '最少购买一件'})
            }
            await this.changeGoodsNum(this.cart, -1)
            this.cart.num -= 1
          })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(HorizontalAlign.Start)
      .height(100)
      .layoutWeight(1)
    }
    .width('100%')
    .padding(Constants.SPACE_16)
    .backgroundColor('#fff')
    .borderRadius(5)
  }
}