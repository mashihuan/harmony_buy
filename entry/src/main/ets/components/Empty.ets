@Component
export default struct Empty {
  private icon: ResourceStr = $r('app.media.icon_empty')
  private iconSize: number = 55
  private padTop: number = 82
  private desc: ResourceStr = '暂无数据...'

  build() {
    Column() {
      Image(this.icon)
        .width(this.iconSize)
        .margin({ bottom: 5 })
      Text(this.desc)
        .fontColor($r('app.color.color_text_tertiary'))
    }
    .width('100%')
    .padding({ left: 82, right: 82, top: this.padTop, bottom: 82 })
  }
}