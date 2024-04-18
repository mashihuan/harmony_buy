import { Constants } from '../../common/Constants'
import CartItem from '../../viewmodel/CartItem'
import CartListItem from './CartListItem'

@Component
export default struct CartList {
  @Link cartList: CartItem[]
  changeGoodsNum: (cart: CartItem, num: number) => Promise<void>

  build() {
    List({ space: Constants.SPACE_12 }) {
      ForEach(this.cartList, (cart: CartItem) => {
        ListItem() {
          CartListItem({cart: cart, changeGoodsNum: this.changeGoodsNum})
        }
      })
    }
    .layoutWeight(1)
    .padding(Constants.SPACE_16)
  }
}