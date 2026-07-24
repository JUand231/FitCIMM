package fitcimm.modelo;

import java.time.LocalDate;
import java.time.LocalTime;

public class Ingreso {

    private int idIngreso;
    private int idSocio;
    private LocalDate fechaIngreso;
    private LocalTime horaIngreso;

    public Ingreso() {
    }

    public Ingreso(int idIngreso, int idSocio, LocalDate fechaIngreso, LocalTime horaIngreso) {
        this.idIngreso = idIngreso;
        this.idSocio = idSocio;
        this.fechaIngreso = fechaIngreso;
        this.horaIngreso = horaIngreso;
    }

    public int getIdIngreso() {
        return idIngreso;
    }

    public void setIdIngreso(int idIngreso) {
        this.idIngreso = idIngreso;
    }

    public int getIdSocio() {
        return idSocio;
    }

    public void setIdSocio(int idSocio) {
        this.idSocio = idSocio;
    }

    public LocalDate getFechaIngreso() {
        return fechaIngreso;
    }

    public void setFechaIngreso(LocalDate fechaIngreso) {
        this.fechaIngreso = fechaIngreso;
    }

    public LocalTime getHoraIngreso() {
        return horaIngreso;
    }

    public void setHoraIngreso(LocalTime horaIngreso) {
        this.horaIngreso = horaIngreso;
    }
}
