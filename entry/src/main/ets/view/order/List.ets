import promptAction from '@ohos.promptAction'
import { BASE_URL } from '../../common/Config'
import { Constants } from '../../common/Constants'
import GoodsItem from '../../viewmodel/GoodsItem'
import OrderGoodsItem from '../../viewmodel/OrderGoodsItem'
import OrderItem from '../../viewmodel/OrderItem'

@Extend(Text) function statusStyle() {
  .width('100%')
  .textAlign(TextAlign.End)
  .fontSize(14)
  .fontColor($r('app.color.color_new_price'))
}

@Extend(Button) function buttonStyle() {
  .height(30)
  .type(ButtonType.Normal)
  .fontSize(13)
  .borderRadius(10)
  .backgroundColor($r('app.color.color_danger'))
}

@Component
export default struct OrderList {
  @Link orderList: OrderItem[]

  build() {
    List({ space: 12 }) {
      ForEach(this.orderList, (order: OrderItem) => {
        ListItem() {
          Column() {
            if(order.status === 1) {
              Text('待支付')
                .statusStyle()
            }
            if(order.status === 2) {
              Text('待收货')
                .statusStyle()
            }
            if(order.status === 3) {
              Text('待评价')
                .statusStyle()
            }

            Column() {
              ForEach((order.goods || []), (goods: OrderGoodsItem) => {
                Row() {
                  Image(BASE_URL + goods.goods.icon)
                    .width(70)
                    .height(70)
                    .margin({ right: 15 })
                  Column() {
                    Text(goods.goods.desc)
                      .width('100%')
                      .margin({ bottom: 15 })
                      .fontSize(14)
                      .fontColor($r('app.color.color_text'))
                      .textOverflow({ overflow: TextOverflow.Ellipsis })
                      .maxLines(2)
                    Row() {
                      Text(`¥${goods.price}`)
                        .fontSize(14)
                        .fontColor($r('app.color.color_new_price'))
                      Text(`x${goods.num}`)
                        .fontSize(14)
                        .fontColor($r('app.color.color_text_tertiary'))
                    }
                    .width('100%')
                    .justifyContent(FlexAlign.SpaceBetween)
                  }
                  .layoutWeight(1)
                }
                .width('100%')
              })
            }
            .width('100%')

            Row() {
              Text(`共${order.total_num}件商品，合计：${order.price.toFixed(2)}元`)
                .fontSize(14)
                .fontColor($r('app.color.color_text_tertiary'))
            }
            .width('100%')
            .margin({ top: 10, bottom: 10 })
            .justifyContent(FlexAlign.End)

            Row() {
              if(order.status === 1) {
                Button('去支付')
                  .buttonStyle()
                  .onClick(() => promptAction.showToast({message: '点击了去支付'}))
              }
              if(order.status === 2) {
                Button('确认收货')
                  .buttonStyle()
                  .onClick(() => promptAction.showToast({message: '点击了确认收货'}))
              }
              if(order.status === 3) {
                Button('去评价')
                  .buttonStyle()
                  .onClick(() => promptAction.showToast({message: '点击了去评价'}))
              }
            }
            .width('100%')
            .justifyContent(FlexAlign.End)
          }
          .width('100%')
          .padding(Constants.SPACE_16)
          .backgroundColor($r('app.color.color_bg_container'))
        }
      })
    }
    .width('100%')
    .height('100%')
    .layoutWeight(1)
    .padding({ top: 12, bottom: 12 })
    .backgroundColor($r('app.color.color_bg_layout'))
  }
}