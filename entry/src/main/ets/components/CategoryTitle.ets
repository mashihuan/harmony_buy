import { Constants } from '../common/Constants'

@Component
export default struct CategoryTitle {
  title: ResourceStr = ''

  build() {
    Row({space: 30}) {
      Divider()
        .width(66)
      Text(this.title)
        .fontSize(17)
      Divider()
        .width(66)
    }
    .margin({bottom: Constants.SPACE_12})
  }
}