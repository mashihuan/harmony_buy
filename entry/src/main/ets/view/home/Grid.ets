import router from '@ohos.router'
import { BASE_URL } from '../../common/Config'
import { Constants } from '../../common/Constants'
import CategoryModel from '../../model/CategoryModel'

type GridInfo = {
  id?: number
  icon: ResourceStr
  name: ResourceStr
  type: 'page' | 'menu' | number
  path?: string
  auth?: boolean
}

@Component
export default struct HomeGrid {
  @Consume currentTabIndex: number
  @Consume categoryId: number
  @State gridList: GridInfo[] = [
    { icon: $r('app.media.category_calendar'), name: '每日签到', path: 'pages/Integral', type: 'page' },
    { icon: $r('app.media.category_member'), name: '大会员', path: 'pages/Member', type: 'page' },
    { icon: $r('app.media.category_invite'), name: '邀请有礼', path: 'pages/Invite', type: 'page' },
    { icon: $r('app.media.category_menu'), name: '四季菜谱', type: 'menu' },
    { icon: $r('app.media.category_more'), name: '更多分类', type: 0, },
  ]

  aboutToAppear() {
    this.getHomeCategory()
  }

  async getHomeCategory() {
    const res = await CategoryModel.getHomeCategory({})
    const categorys = res.data.categorys || []
    this.gridList = categorys.concat(this.gridList)
  }

  onGridItemClick(grid: GridInfo) {
    if (grid.type === 'page') {
      router.pushUrl({
        url: grid.path
      })
    } else if (grid.type === 'menu') {
      this.currentTabIndex = 2
    } else {
      this.currentTabIndex = 1
      this.categoryId = grid.id || this.gridList[0]?.id
    }
  }

  build() {
    Grid() {
      ForEach(this.gridList, (grid: GridInfo) => {
        GridItem() {
          Column() {
            Image(grid.type === 1 ? (BASE_URL + grid.icon) : grid.icon)
              .width(55)
              .height(55)
              .margin({ bottom: Constants.SPACE_12 })
            Text(grid.name)
              .fontSize(14)
          }
          .width('100%')
          .onClick(() => this.onGridItemClick(grid))
        }
      })
    }
    .width('100%')
    .height(202)
    .padding({ top: Constants.SPACE_12, bottom: Constants.SPACE_12 })
    .margin({ bottom: Constants.SPACE_12 })
    .backgroundColor($r('app.color.color_bg_container'))
    .columnsTemplate('1fr 1fr 1fr 1fr 1fr')
    .rowsGap(Constants.SPACE_12)
  }
}