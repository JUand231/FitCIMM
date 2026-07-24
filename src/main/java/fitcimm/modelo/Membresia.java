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
    private String estado;

    public Membresia() {
    }

    public Membresia(int idMembresia, int idSocio, int idPlan, String nombrePlan, LocalDate fechaInicio, LocalDate fechaFin, double valorPagado, String estado) {
        this.idMembresia = idMembresia;
        this.idSocio = idSocio;
        this.idPlan = idPlan;
        this.nombrePlan = nombrePlan;
        this.fechaInicio = fechaInicio;
        this.fechaFin = fechaFin;
        this.valorPagado = valorPagado;
        this.estado = estado;
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

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }
}
