class StocksController < AuthorizedController

  def inventory
    sql = "
      select p.code as product_code, p.name as product_name
          , p.specification as product_spec
          , c.name as customer_name
          , a.quantity
      from (
        select sp.product_id, sum(
          case s.opt_type
            when 1 then sp.quantity
            when 2 then - sp.quantity
          end ) as quantity
        from stocks s
        inner join stock_products sp on sp.stock_id = s.id
        where s.status = 'complete'
        group by sp.product_id
      ) a
      inner join products p on p.id = a.product_id
      inner join customers c on c.id = p.customer_id
      where p.name like '%#{params[:by_text]}%'
      or p.specification like '%#{params[:by_text]}%'
      or c.name like '%#{params[:by_text]}%'
    "
    @inventories = Stock.paginate_by_sql(sql, :page => params[:page], :per_page => params[:per_page])

  end

end
