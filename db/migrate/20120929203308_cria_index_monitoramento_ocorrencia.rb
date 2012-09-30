class CriaIndexMonitoramentoOcorrencia < Mongoid::Migration
  def self.up
    ocorrencias = MonitoramentoOcorrencia.all
    ocorrencias.each do |mo|
      if mo.monitoramento.nil?
        puts "Ocorrencia perdida removida = #{mo} #{mo.hora} #{mo.camera.nome}"
        mo.destroy
        next
      end

      mo.user = mo.monitoramento.user
      mo.data = mo.monitoramento.data
      mo.ocorrencia = mo.ocorrencia_item.ocorrencia
      mo.save
    end
  end

  def self.down
  end
end