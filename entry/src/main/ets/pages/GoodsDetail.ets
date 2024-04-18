import router from '@ohos.router'
import promptAction from '@ohos.promptAction'
import { BASE_URL } from '../common/Config'
import { Constants } from '../common/Constants'
import Empty from '../components/Empty'
import NavigationBar from '../components/NavigationBar'
import CartModel from '../model/CartModel'
import CartItem from '../viewmodel/CartItem'
import GoodsModel from '../model/GoodsModel'
import GoodsItem, { GoodsBanner } from '../viewmodel/GoodsItem'

@Styles function boxStyle() {
  .width('100%')
  .margin({ bottom: 12 })
  .padding({ left: Constants.SPACE_16, right: Constants.SPACE_16, top: 12, bottom: 12 })
  .backgroundColor($r('app.color.color_bg_container'))
}

@Entry
@Component
struct GoodsDetail {
  @State goodsInfo: GoodsItem = {
    id: 0,
    name: '',
    desc: '',
    icon: '',
    new_price: 0,
    old_price: 0,
    category_id: 0,
    banner: []
  }
  @State goodsId: string = ''

  aboutToAppear() {
    const params = router.getParams() as any
    this.goodsId = params?.id
    this.getGoodsDetail()
  }

  async getGoodsDetail() {
    const res = await GoodsModel.requestGoodsDetail({ id: this.goodsId })
    this.goodsInfo = res.data?.goods || {}
  }

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
      NavigationBar({ title: '商品详情' })
      Scroll() {
        Column() {
          if (this.goodsInfo.banner && this.goodsInfo.banner.length) {
            Swiper() {
              ForEach(this.goodsInfo.banner, (banner: GoodsBanner) => {
                Image(BASE_URL + banner.url)
                  .width('100%')
                  .height(414)
              })
            }
            .indicatorStyle({ selectedColor: $r('app.color.color_primary') })
          }
          Column() {
            Row() {
              Text('¥')
                .fontSize(14)
                .fontColor($r('app.color.color_new_price'))
              Text(this.goodsInfo.new_price.toString())
                .fontSize(25)
                .fontColor($r('app.color.color_new_price'))
            }
            .width('100%')

            Text(this.goodsInfo.desc)
              .width('100%')
              .margin({ top: 12, bottom: 12 })
              .fontSize(17)
              .fontWeight(700)
              .fontColor($r('app.color.color_text'))
              .lineHeight(24)
            Row() {
              Button('加入购物车')
                .height(30)
                .backgroundColor($r('app.color.bg_primary'))
                .fontSize(13)
                .onClick(() => {
                  this.onAddToCart(this.goodsInfo)
                })
            }
            .width('100%')
            .justifyContent(FlexAlign.End)
          }
          .boxStyle()

          Column() {
            Row() {
              Text('商品评价')
                .fontSize(17)
                .fontColor($r('app.color.color_text'))
            }
            .width('100%')
            .margin({ bottom: 16 })

            Empty({ desc: '暂无评价...', icon: $r('app.media.icon_comment'), padTop: 16 })
          }
          .boxStyle()
        }
        .padding({ bottom: Constants.SPACE_16 })
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.color_bg_layout'))
  }
}