import router from '@ohos.router'
import Empty from '../components/Empty'
import NavigationBar from '../components/NavigationBar'

@Entry
@Component
struct AfterSale {
  @State currentTabIndex: number = 0

  aboutToAppear() {
    const params = router.getParams() as any
    this.currentTabIndex = params.index || 0
  }

  build() {
    Column() {
      NavigationBar({ title: '我的售后' })
      Tabs({ index: this.currentTabIndex }) {
        TabContent() {
          Column() {
            Empty({ desc: '暂无记录...' })
          }
          .width('100%')
          .height('100%')
        }
        .tabBar(this.TabBuilder('售后申请', 0))

        TabContent() {
          Column() {
            Empty({ desc: '暂无记录...' })
          }
          .width('100%')
          .height('100%')
        }
        .tabBar(this.TabBuilder('申请记录', 1))
      }
      .onChange((index) => {
        this.currentTabIndex = index
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.color_bg_layout'))
  }

  @Builder TabBuilder(text: ResourceStr, index: number) {
    Row() {
      if (this.currentTabIndex === index) {
        Text(text)
          .height('100%')
          .fontColor($r('app.color.color_primary'))
          .border({ width: { bottom: 2 }, style: BorderStyle.Solid, color: $r('app.color.color_primary') })
      } else {
        Text(text)
          .fontColor($r('app.color.color_text_tertiary'))
      }
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .backgroundColor($r('app.color.color_bg_container'))
    .border({ width: { bottom: 1 }, style: BorderStyle.Solid, color: $r('app.color.color_border_secondary') })
  }
}