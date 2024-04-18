import router from '@ohos.router'
import promptAction from '@ohos.promptAction'
import { BASE_URL } from '../common/Config'
import { Constants } from '../common/Constants'
import NavigationBar from '../components/NavigationBar'
import MenuModel from '../model/MenuModel'
import MenuItem, { MenuFoodsItem, MenuStepsItem } from '../viewmodel/MenuItem'

@Entry
@Component
struct MenuDetail {
  menuId: string = ''
  @State menuInfo: MenuItem = {
    id: 0,
    img: '',
    name: '',
    desc: '',
    foods: [],
    steps: []
  }

  aboutToAppear() {
    const params = router.getParams() as any
    this.menuId = params.id
    this.getMenuDetail()
  }

  async getMenuDetail() {
    const res = await MenuModel.requestMenuDetail({
      id: this.menuId
    })
    this.menuInfo = res.data?.menu
  }

  build() {
    Column() {
      NavigationBar({ title: '菜谱详情' })
      Scroll() {
        Column() {
          Column() {
            Image(BASE_URL + this.menuInfo.img)
              .width('100%')
              .height(230)
            Text(this.menuInfo.desc)
              .width('100%')
              .padding(5)
              .fontColor($r('app.color.color_text'))
              .lineHeight(24)
            Row() {
              Text(this.menuInfo.name)
                .fontSize(17)
                .fontColor($r('app.color.color_text'))
                .fontWeight(700)
              Button('立即分享')
                .height(30)
                .backgroundColor($r('app.color.bg_primary'))
                .fontSize(13)
                .onClick(() => {
                  promptAction.showToast({ message: '点击了分享' })
                })
            }
            .width('100%')
            .padding(Constants.SPACE_16)
            .justifyContent(FlexAlign.SpaceBetween)
          }
          .margin({ bottom: Constants.SPACE_12 })
          .backgroundColor($r('app.color.color_bg_container'))

          Column({ space: 19 }) {
            Text('食材清单')
              .width('100%')
              .fontSize(18)
              .fontColor($r('app.color.color_text'))
            if (this.menuInfo.foods && this.menuInfo.foods.length) {
              ForEach(this.menuInfo.foods, (foodsItem: MenuFoodsItem) => {
                Row() {
                  Text(foodsItem.label)
                    .width('70%')
                    .fontSize(15)
                    .fontColor($r('app.color.color_text'))
                  Text(foodsItem.value)
                    .width('30%')
                    .fontSize(15)
                    .fontColor($r('app.color.color_text'))
                }
                .width('100%')
              })
            }
          }
          .padding(Constants.SPACE_16)
          .margin({ bottom: Constants.SPACE_12 })
          .backgroundColor($r('app.color.color_bg_container'))

          Column({ space: 16 }) {
            Text('烹饪步骤')
              .width('100%')
              .fontSize(18)
              .fontColor($r('app.color.color_text'))
            if (this.menuInfo.steps && this.menuInfo.steps.length) {
              ForEach(this.menuInfo.steps, (stepsItem: MenuStepsItem, index: number) => {
                Column() {
                  Text(`步骤 ${index + 1}/${this.menuInfo.steps.length}`)
                    .width('100%')
                  Image(BASE_URL + stepsItem.img)
                    .width('100%')
                    .height(198)
                    .margin({ top: 12, bottom: 12 })
                    .borderRadius(8)
                  Text(stepsItem.desc)
                    .width('100%')
                    .fontSize(15)
                    .fontColor($r('app.color.color_text'))
                    .lineHeight(22)
                }
                .width('100%')
              })
            }
          }
          .padding(Constants.SPACE_16)
          .margin({ bottom: Constants.SPACE_12 })
          .backgroundColor($r('app.color.color_bg_container'))
        }
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.color_bg_layout'))
  }
}