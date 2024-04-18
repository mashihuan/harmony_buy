import router from '@ohos.router'
import promptAction from '@ohos.promptAction'
import { BASE_URL } from '../common/Config'
import { Constants } from '../common/Constants'
import CartModel from '../model/CartModel'
import CartItem from '../viewmodel/CartItem'
import GoodsItem from '../viewmodel/GoodsItem'
import CategoryTitle from './CategoryTitle'

@Component
export default struct GoodsList {
  title: ResourceStr
  banner: ResourceStr
  @Link goodsList: GoodsItem[]

  async onAddToCart(goods: GoodsItem) {
    // 查看购物车是否已有该商品
    const carts = await CartModel.query()
    const currentCart: CartItem = carts.find((cart: CartItem) => cart.goods_id === goods.id)
    if (currentCart) { // 已有则直接数量+1
      await CartModel.update(currentCart.id, {
        goods_id: goods.id,
        num: currentCart.num + 1
      })
    } else { // 没有则新增
      await CartModel.insert({
        goods_id: goods.id,
        num: 1
      })
    }
    promptAction.showToast({ message: '加入购物车成功' })
  }

  build() {
    Column() {
      CategoryTitle({ title: this.title })
      if (this.banner) {
        Image(this.banner)
          .width('100%')
          .height(165)
          .margin({ bottom: Constants.SPACE_12 })
      }
      List({ space: 5 }) {
        ForEach(this.goodsList, (goods: GoodsItem) => {
          ListItem() {
            Column() {
              Image(BASE_URL + goods.icon)
                .width('100%')
                .height(120)
                .onClick(() => {
                  router.pushUrl({
                    url: 'pages/GoodsDetail',
                    params: { id: goods.id }
                  })
                })
              Text(goods.desc)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
                .maxLines(2)
                .fontSize(13)
                .lineHeight(17)
              Text('¥' + goods.new_price.toFixed(1))
                .margin({ top: 3 })
                .fontColor($r('app.color.color_new_price'))
                .fontSize(13)
              Row() {
                Text('¥' + goods.old_price.toFixed(1))
                  .fontColor($r('app.color.color_old_price'))
                  .fontSize(13)
                  .decoration({ type: TextDecorationType.LineThrough })
                Blank()
                Image($r('app.media.icon_cart'))
                  .fillColor('#f0250f')
                  .width(20)
                  .width(20)
                  .margin({ right: Constants.SPACE_12 })
                  .onClick(() => {
                    this.onAddToCart(goods)
                  })
              }
              .width('100%')
            }
            .width(120)
            .alignItems(HorizontalAlign.Start)
          }
        })
      }
      .listDirection(Axis.Horizontal)
    }
    .width('100%')
    .padding(Constants.SPACE_12)
    .margin({ bottom: Constants.SPACE_12 })
    .backgroundColor($r('app.color.color_bg_container'))
  }
}