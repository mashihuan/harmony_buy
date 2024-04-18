import relationalStore from '@ohos.data.relationalStore'
import { ColumnInfo, ColumnType } from '../common/ColumnInfo'
import RdbUtil from '../utils/RdbUtil'

const TABLE_NAME = 'cart'

const CREATE_TABLE_SQL = `CREATE TABLE IF NOT EXISTS ${TABLE_NAME} (id INTEGER PRIMARY KEY AUTOINCREMENT, goods_id INTEGER NOT NULL, num INTEGER NOT NULL)`

const COLUMNS: ColumnInfo[] = [
  { name: 'id', columnName: 'id', type: ColumnType.LONG },
  // { name: 'user_id', columnName: 'user_id', type: ColumnType.LONG },
  { name: 'goods_id', columnName: 'goods_id', type: ColumnType.LONG },
  { name: 'num', columnName: 'num', type: ColumnType.LONG },
]

class CartModel {
  getCreateTableSql() {
    return CREATE_TABLE_SQL
  }

  async insert(data: any) {
    return RdbUtil.insert(TABLE_NAME, data, COLUMNS)
  }

  async update(id: number, data: any) {
    const predicates = new relationalStore.RdbPredicates(TABLE_NAME)
    predicates.equalTo('id', id)
    return RdbUtil.update(predicates, data, COLUMNS)
  }

  async delete(id: number) {
    const predicates = new relationalStore.RdbPredicates(TABLE_NAME)
    predicates.equalTo('id', id)
    return RdbUtil.delete(predicates)
  }

  async deleteList(ids: number[]) {
    const predicates = new relationalStore.RdbPredicates(TABLE_NAME)
    predicates.in('id', ids)
    return RdbUtil.delete(predicates)
  }

  async query() {
    const predicates = new relationalStore.RdbPredicates(TABLE_NAME)
    // predicates.isNotNull('id')
    return RdbUtil.query(predicates, COLUMNS)
  }
}

export default new CartModel