import router from '@ohos.router'

@Styles function iconWrapperStyle() {
  .width(32)
  .height(32)
  .margin({ left: 2, right: 2 })
}

@Extend(Circle) function circleStyle() {
  .width('100%')
  .height('100%')
  .fill('#000')
  .fillOpacity(0.4)
}

@Extend(Image) function imageStyle() {
  .width(22)
  .height(22)
}

@Extend(Text) function textStyle(contentColor: ResourceStr) {
  .fontColor(contentColor || '#fff')
  .fontSize(14)
}

@Component
export default struct NavigationBar {
  private hiddenBack: boolean
  private title: ResourceStr
  private bgColor: ResourceStr
  private contentColor: ResourceStr
  private bordered: boolean
  private leftIcon: ResourceStr
  private leftText: ResourceStr
  private rightIcon: ResourceStr
  private rightText: ResourceStr
  private clickLeft: () => void
  private clickTitle: () => void
  private clickRight: () => void
  // @BuilderParam titleBuilderParam: () => void

  build() {
    Row() {
      Row() {
        if (!this.hiddenBack) {
          Button({ type: ButtonType.Circle }) {
            Image($r('app.media.arrow_left'))
              .width(27)
              .height(27)
          }
          .iconWrapperStyle()
          .backgroundColor('transparent')
          .onClick(() => router.back())
        }

        Stack() {
          if (this.leftIcon) {
            Stack() {
              Circle()
                .circleStyle()
              Image(this.leftIcon)
                .imageStyle()
            }
            .iconWrapperStyle()
          } else {
            if (this.leftText) {
              Text(this.leftText)
                .iconWrapperStyle()
                .textStyle(this.contentColor)
            }
          }
        }
        .onClick(() => this.clickLeft && this.clickLeft())
      }
      .width(70)

      if (this.title) {
        Text(this.title)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
          .fontSize(17)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.contentColor || '#fff')
          .onClick(() => this.clickTitle && this.clickTitle())
      } else {
        // Row() {
        //   this.titleBuilderParam()
        // }
        // .layoutWeight(1)
      }

      Row() {
        Stack() {
          if (this.rightIcon) {
            Stack() {
              Circle()
                .circleStyle()
              Image(this.rightIcon)
                .imageStyle()
            }
            .iconWrapperStyle()
          } else {
            if (this.rightText) {
              Text(this.rightText)
                .iconWrapperStyle()
                .textStyle(this.contentColor)
            }
          }
        }
        .onClick(() => this.clickRight && this.clickRight())
      }
      .width(70)
      .justifyContent(FlexAlign.End)
    }
    .width('100%')
    .height(44)
    .padding({ left: 3, right: 3 })
    .backgroundColor(this.bgColor || $r('app.color.bg_primary'))
    .border({ width: { bottom: this.bordered ? 0.5 : 0 }, style: BorderStyle.Solid, color: '#eee' })
  }
}