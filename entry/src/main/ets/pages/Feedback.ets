import promptAction from '@ohos.promptAction'
import NavigationBar from '../components/NavigationBar'

@Entry
@Component
struct Feedback {
  @State text: string = ''

  build() {
    Column() {
      NavigationBar({ title: '意见反馈' })
      TextArea({ text: this.text, placeholder: '我们想听听你的心声,如果愿意,你也可以留下联系方式,我们期待与您的真诚沟通.' })
        .height(220)
        .backgroundColor('#fff')
        .onChange(val => this.text = val)
      Button('提交')
        .width('90%')
        .position({ x: '5%', y: '90%' })
        .backgroundColor($r('app.color.bg_primary'))
        .onClick(() => {
          promptAction.showToast({ message: '点击了提交' })
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.color_bg_layout'))
  }
}