

def build_bill_no(model, fix, l)
  now = Time.now.strftime("%y%m%d")

  if model.exists?
    l_code = model.where(["bill_no like ?", "#{fix}#{now}%"]).maximum(:bill_no)
    if l_code
      m_code = l_code[fix.length + now.length,l.to_i]
    else
      m_code = 0
    end
  else
    m_code = 0
  end

  return fix + now + ("%0" + l.to_s + "i") % (m_code.to_i + 1)
end

def build_code(model, fix, l)
  if model.exists?
    l_code = model.last.code
    m_code = l_code[fix.length,l.to_i]
  else
    m_code = 0
  end

  return fix + ("%0" + l.to_s + "i") % (m_code.to_i + 1)
end

