import router from '@ohos.router'
import { Constants } from '../../common/Constants'
import NavigationBar from '../../components/NavigationBar'
import MineCoupon from './Coupon'
import MineOrder from './Order'
import MineProfile from './Profile'
import MineTool from './Tool'


@Component
export default struct MineIndex {
  build() {
    Column() {
      NavigationBar({
        hiddenBack: true,
        bordered: true,
        title: '个人中心',
        rightIcon: $r('app.media.icon_notice'),
        clickRight: () => {
          router.pushUrl({ url: 'pages/Message' })
        }
      })
      MineProfile()
      Column({ space: Constants.SPACE_12 }) {
        MineCoupon()
        MineOrder()
        MineTool()
      }
      .padding({ left: Constants.SPACE_16, right: Constants.SPACE_16 })
    }
    .width('100%')
    .height('100%')
  }
}