export class MenuFoodsItem {
  id: number
  label: string
  value: string
  menu_id: number
}

export class MenuStepsItem {
  id: number
  img: string
  desc: string
  menu_id: number
}

export default class MenuItem {
  id: number
  name: string
  desc: string
  img: string
  foods?: MenuFoodsItem[]
  steps?: MenuStepsItem[]
}