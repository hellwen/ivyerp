# encoding: utf-8

# Main seed file
# ==============
# You probably want to load a local specific seed file from seeds/locales!


# Authorization
# =============
Role.create!([
  {:name => 'admin'},
  {:name => 'base'},
])

# Test Admin User
User.create!([
  {:username => 'test', :email => 'test@gmail.com', :password => '1qaz2wsx', :role_texts => ['admin']},
])

# Jobs
# =============
Job.create!([
  {:name => '总经理'},
  {:name => '业务经理'},
  {:name => '业务员'},
  {:name => '采购经理'},
  {:name => '采购员'},
  {:name => '财务经理'},
  {:name => '会计'},
  {:name => '仓库主管'},
  {:name => '仓管员'},
  {:name => '厂长'},
  {:name => '车间主任'},
  {:name => '班长'},
])

# Departments
# =============
Department.create!([
  {:name => '总经办'},
  {:name => '业务部'},
  {:name => '采购部'},
  {:name => '车间'},
  {:name => '仓库'},
])

# Workshops
# =============
Workshop.create!([
  {:name => '过胶'},
  {:name => '打扣'},
  {:name => '挖孔'},
  {:name => '点数'},
])
