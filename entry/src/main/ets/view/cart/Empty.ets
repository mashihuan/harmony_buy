import { Constants } from '../../common/Constants'

@Component
export default struct CartEmpty {
  @Prop text: string

  build() {
    Column() {
      Stack() {
        Circle()
          .width(110)
          .height(110)
          .fill($r('app.color.bg_primary'))
        Image($r('app.media.icon_cart_empty'))
          .width(60)
      }

      Text(this.text)
        .margin({ top: Constants.SPACE_16, bottom: Constants.SPACE_16 })
        .fontColor($r('app.color.color_text'))
    }
    .width('100%')
    .padding({ top: 165 })
  }
}