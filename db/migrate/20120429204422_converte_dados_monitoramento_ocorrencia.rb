class ConverteDadosMonitoramentoOcorrencia < Mongoid::Migration
  def self.up
=begin
    monitoramentos = Monitoramento.all
    monitoramentos.each do |m|
      m.ocorrencia_itens.each do |o|
        mo = MonitoramentoOcorrencia.new
        mo.ocorrencia_item=o
        mo.monitoramento=m
        mo.save
      end
    end
=end
    puts "Ja executado: ConverteDadosMonitoramentoOcorrencia"
  end

  def self.down
  end
end