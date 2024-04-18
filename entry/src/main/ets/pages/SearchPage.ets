import router from '@ohos.router'
import { Constants } from '../common/Constants'
import GoodsModel from '../model/GoodsModel'
import { debounce } from '../utils/Index'
import GoodsItem from '../viewmodel/GoodsItem'

@Entry
@Component
struct SearchPage {
  @State keyword: string = ''
  @State goodsList: GoodsItem[] = []
  newGetGoodsByKeyword: () => void

  onPageShow() {
    const getGoodsByKeyword = async () => {
      const res = await GoodsModel.requestGoodsByCategory({
        keyword: this.keyword
      })
      this.goodsList = res.data?.goods || []
    }
    this.newGetGoodsByKeyword = debounce(getGoodsByKeyword)
  }

  onInputChange(val: string) {
    this.keyword = val
    this.newGetGoodsByKeyword()
  }

  build() {
    Column() {
      Row() {
        Row() {
          Image($r('app.media.arrow_left'))
            .width(23)
            .fillColor($r('app.color.color_text'))
            .onClick(() => router.back())
        }
        .padding(12)

        Search({ value: this.keyword, placeholder: '请输入' })
          .height(28)
          .layoutWeight(1)
          .placeholderColor($r('app.color.color_text_tertiary'))
          .backgroundColor($r('app.color.color_bg_layout'))
          .onChange(val => this.onInputChange(val))
      }
      .width('100%')
      .padding({ right: Constants.SPACE_16 })
      .backgroundColor($r('app.color.color_bg_container'))
      .border({ width: { bottom: 1 }, style: BorderStyle.Solid, color: $r('app.color.color_border') })

      List() {
        ForEach(this.goodsList, (goods: GoodsItem) => {
          ListItem() {
            Text(goods.name)
              .width('100%')
              .padding({ top: 14, bottom: 14 })
              .border({ width: { bottom: 1 }, style: BorderStyle.Solid, color: $r('app.color.color_border_secondary') })
              .fontColor($r('app.color.color_text'))
          }
        })
      }
      .width('100%')
      .height('100%')
      .layoutWeight(1)
      .padding({ left: Constants.SPACE_16, right: Constants.SPACE_16 })
      .backgroundColor($r('app.color.color_bg_container'))
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.color_bg_layout'))
  }
}