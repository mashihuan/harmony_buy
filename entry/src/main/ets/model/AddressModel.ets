import relationalStore from '@ohos.data.relationalStore'
import { ColumnInfo, ColumnType } from '../common/ColumnInfo'
import RdbUtil from '../utils/RdbUtil'

const TABLE_NAME = 'address'

const CREATE_TABLE_SQL = `CREATE TABLE IF NOT EXISTS ${TABLE_NAME} (id INTEGER PRIMARY KEY AUTOINCREMENT, name STRING NOT NULL, phone STRING NOT NULL, area STRING NOT NULL, detail STRING NOT NULL, is_default LONG NOT NULL)`

const COLUMNS: ColumnInfo[] = [
  { name: 'id', columnName: 'id', type: ColumnType.LONG },
  // { name: 'user_id', columnName: 'user_id', type: ColumnType.LONG },
  { name: 'name', columnName: 'name', type: ColumnType.STRING },
  { name: 'phone', columnName: 'phone', type: ColumnType.STRING },
  { name: 'area', columnName: 'area', type: ColumnType.STRING },
  { name: 'detail', columnName: 'detail', type: ColumnType.STRING },
  { name: 'is_default', columnName: 'is_default', type: ColumnType.LONG },
]

class AddressModel {
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

  async queryById(id: number) {
    const predicates = new relationalStore.RdbPredicates(TABLE_NAME)
    predicates.equalTo('id', id)
    return RdbUtil.query(predicates, COLUMNS)
  }
}

export default new AddressModel