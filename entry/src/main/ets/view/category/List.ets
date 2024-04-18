import router from '@ohos.router'
import { BASE_URL } from '../../common/Config'
import { Constants } from '../../common/Constants'
import CategoryItem from '../../viewmodel/CategoryItem'
import GoodsItem from '../../viewmodel/GoodsItem'

@Extend(Text) function categoryText() {
  .width('100%')
  .height(50)
  .fontSize(14)
  .maxLines(1)
  .textOverflow({ overflow: TextOverflow.Ellipsis })
  .textAlign(TextAlign.Center)
}

@Component
export default struct CategoryList {
  @Consume categoryId: number
  @Link categoryList: CategoryItem[]
  @Link goodsList: GoodsItem[]

  build() {
    Row() {
      Column() {
        List() {
          ForEach(this.categoryList, (category: CategoryItem) => {
            ListItem() {
              Row() {
                if (category.id === this.categoryId) {
                  Text(category.name)
                    .categoryText()
                    .backgroundColor('#fff')
                } else {
                  Text(category.name)
                    .categoryText()
                }
              }
            }
            .onClick(() => this.categoryId = category.id)
          })
        }
        .width('100%')
        .height('100%')
        .layoutWeight(1)
      }
      .width('25%')
      .height('100%')
      .backgroundColor('#f2f2f2')

      Column() {
        Grid() {
          ForEach(this.goodsList, (goods: GoodsItem) => {
            GridItem() {
              Column() {
                Image(BASE_URL + goods.icon)
                  .width(64)
                  .height(64)
                  .margin({ bottom: Constants.SPACE_10 })
                Text(goods.name)
                  .fontSize(13)
              }
              .onClick(() => {
                router.pushUrl({
                  url: 'pages/GoodsDetail',
                  params: { id: goods.id }
                })
              })
            }
          })
        }
        .columnsTemplate('1fr 1fr 1fr')
        .rowsGap(Constants.SPACE_14)
        .padding({ top: Constants.SPACE_14 })
        .backgroundColor($r('app.color.color_bg_container'))
      }
      .width('75%')
    }
    .padding({ top: 44 })
  }
}