@CustomDialog
export default struct Loading {
  controller: CustomDialogController

  confirm: () => void

  build() {
    LoadingProgress()
      .width(50)
      .height(50)
      .color($r('app.color.color_primary'))
      .backgroundColor('')
  }
}