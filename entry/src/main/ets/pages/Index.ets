import CartIndex from '../view/cart/Index'
import CategoryIndex from '../view/category/Index'
import HomeIndex from '../view/home/Index'
import MenuIndex from '../view/menu/Index'
import MineIndex from '../view/mine/Index'

@Entry
@Component
struct Index {
  @Provide currentTabIndex: number = 0
  @Provide categoryId: number = 0

  build() {
    Tabs({ barPosition: BarPosition.End, index: this.currentTabIndex }) {
      TabContent() {
        HomeIndex()
      }
      .tabBar(this.TabBuilder($r('app.media.home'), $r('app.media.home_active'), '首页', 0))

      TabContent() {
        CategoryIndex()
      }
      .tabBar(this.TabBuilder($r('app.media.category'), $r('app.media.category_active'), '分类', 1))

      TabContent() {
        MenuIndex()
      }
      .tabBar(this.TabBuilder($r('app.media.menu'), $r('app.media.menu_active'), '吃什么', 2))

      TabContent() {
        CartIndex()
      }
      .tabBar(this.TabBuilder($r('app.media.cart'), $r('app.media.cart_active'), '购物车', 3))

      TabContent() {
        MineIndex()
      }
      .tabBar(this.TabBuilder($r('app.media.mine'), $r('app.media.mine_active'), '我的', 4))
    }
    .vertical(false)
    .scrollable(false)
    .barMode(BarMode.Fixed)
    .backgroundColor($r('app.color.color_bg_layout'))
    .onChange((index: number) => {
      this.currentTabIndex = index
    })
  }

  @Builder TabBuilder(icon: ResourceStr, activeIcon: ResourceStr, text: ResourceStr, index: number) {
    Column() {
      Image(this.currentTabIndex === index ? activeIcon : icon)
        .width(24)
        .height(24)
      Text(text)
        .margin({ top: 3 })
        .fontSize(10)
        .fontColor(this.currentTabIndex === index ? $r('app.color.color_primary') : $r('app.color.color_text_secondary'))
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .backgroundColor($r('app.color.color_bg_container'))
  }
}