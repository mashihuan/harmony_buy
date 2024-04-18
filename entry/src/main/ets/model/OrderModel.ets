import relationalStore from '@ohos.data.relationalStore'
import { ColumnInfo, ColumnType } from '../common/ColumnInfo'
import RdbUtil from '../utils/RdbUtil'

export enum OrderStatus {
  ALL,
  NO_PAY,
  NO_DELIVERY,
  NO_COMMENT
}

const TABLE_NAME = 'order_list'

const CREATE_TABLE_SQL = `CREATE TABLE IF NOT EXISTS ${TABLE_NAME} (id INTEGER PRIMARY KEY AUTOINCREMENT, address_id INTEGER NOT NULL, status INTEGER NOT NULL)`

const COLUMNS: ColumnInfo[] = [
  { name: 'id', columnName: 'id', type: ColumnType.LONG },
  // { name: 'user_id', columnName: 'user_id', type: ColumnType.LONG },
  { name: 'address_id', columnName: 'address_id', type: ColumnType.LONG },
  { name: 'status', columnName: 'status', type: ColumnType.LONG },
]

class OrderModel {
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

  async queryByStatus(status: number) {
    const predicates = new relationalStore.RdbPredicates(TABLE_NAME)
    if(status !== 0) {
      predicates.equalTo('status', status)
    }
    return RdbUtil.query(predicates, COLUMNS)
  }
}

export default new OrderModel