import Empty from '../components/Empty'
import NavigationBar from '../components/NavigationBar'

@Entry
@Component
struct Message {
  build() {
    Column() {
      NavigationBar({ title: '消息中心' })
      Scroll() {
        Column() {
          Empty({ desc: '暂无消息...' })
        }
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.color_bg_layout'))
  }
}