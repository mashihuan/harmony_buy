import { Constants } from '../../common/Constants'
import MenuItem from '../../viewmodel/MenuItem'
import CategoryTitle from '../../components/CategoryTitle'
import MenuModel from '../../model/MenuModel'
import { BASE_URL } from '../../common/Config'
import router from '@ohos.router'

@Component
export default struct MenuList {
  @State menuList: MenuItem[] = []

  aboutToAppear() {
    this.getMenuList()
  }

  async getMenuList() {
    const res = await MenuModel.requestMenu({})
    this.menuList = res.data?.menus || []
  }

  build() {
    Column() {
      CategoryTitle({title: '今日菜单'})
      Flex({wrap: FlexWrap.Wrap, justifyContent: FlexAlign.SpaceBetween}) {
        ForEach(this.menuList, (menu: MenuItem) => {
          Column() {
            Image(BASE_URL + menu.img)
              .width('100%')
              .height(132)
              .margin({bottom: Constants.SPACE_12})
            Text(menu.name)
              .fontSize(14)
          }
          .width('48%')
          .margin({bottom: Constants.SPACE_12})
          .onClick(() => {
            router.pushUrl({
              url: 'pages/MenuDetail',
              params: { id: menu.id }
            })
          })
        })
      }
      .margin({bottom: Constants.SPACE_12})
    }
    .width('100%')
    .padding(Constants.SPACE_12)
    .backgroundColor('#fff')
  }
}