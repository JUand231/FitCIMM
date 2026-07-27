package fitcimm.modelo;

import java.time.LocalDate;

public class Membresia {

    private int idMembresia;
    private int idSocio;
    private int idPlan;
    private String nombrePlan;
    private LocalDate fechaInicio;
    private LocalDate fechaFin;
    private double valorPagado;

    private Socio socio;
    private Plan plan;

    public Membresia() {
    }

    public Membresia(int idMembresia, int idSocio, int idPlan, String nombrePlan, LocalDate fechaInicio, LocalDate fechaFin, double valorPagado, Socio socio, Plan plan) {
        this.idMembresia = idMembresia;
        this.idSocio = idSocio;
        this.idPlan = idPlan;
        this.nombrePlan = nombrePlan;
        this.fechaInicio = fechaInicio;
        this.fechaFin = fechaFin;
        this.valorPagado = valorPagado;
        this.socio = socio;
        this.plan = plan;
    }

    public int getIdMembresia() {
        return idMembresia;
    }

    public void setIdMembresia(int idMembresia) {
        this.idMembresia = idMembresia;
    }

    public int getIdSocio() {
        return idSocio;
    }

    public void setIdSocio(int idSocio) {
        this.idSocio = idSocio;
    }

    public int getIdPlan() {
        return idPlan;
    }

    public void setIdPlan(int idPlan) {
        this.idPlan = idPlan;
    }

    public String getNombrePlan() {
        return nombrePlan;
    }

    public void setNombrePlan(String nombrePlan) {
        this.nombrePlan = nombrePlan;
    }

    public LocalDate getFechaInicio() {
        return fechaInicio;
    }

    public void setFechaInicio(LocalDate fechaInicio) {
        this.fechaInicio = fechaInicio;
    }

    public LocalDate getFechaFin() {
        return fechaFin;
    }

    public void setFechaFin(LocalDate fechaFin) {
        this.fechaFin = fechaFin;
    }

    public double getValorPagado() {
        return valorPagado;
    }

    public void setValorPagado(double valorPagado) {
        this.valorPagado = valorPagado;
    }

    public Socio getSocio() {
        return socio;
    }

    public void setSocio(Socio socio) {
        this.socio = socio;
    }

    public Plan getPlan() {
        return plan;
    }

    public void setPlan(Plan plan) {
        this.plan = plan;
    }

    public EstadoMembresia getEstadoMembresia() {

        if (fechaFin == null) {
            return null;
        }

        LocalDate hoy = LocalDate.now();

        if (fechaFin.isBefore(hoy)) {
            return EstadoMembresia.VENCIDA;
        }

        if (!fechaFin.isAfter(hoy.plusDays(5))) {
            return EstadoMembresia.POR_VENCER;
        }

        return EstadoMembresia.VIGENTE;
    }

}
