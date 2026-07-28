package fitcimm.modelo;

import java.time.LocalDate;
import java.time.LocalTime;

public class ConsultaIngreso {

    private String documento;
    private String nombres;
    private String apellidos;
    private LocalDate fechaIngreso;
    private LocalTime horaIngreso;

    public ConsultaIngreso() {
    }

    public ConsultaIngreso(String documento, String nombres, String apellidos,
            LocalDate fechaIngreso, LocalTime horaIngreso) {
        this.documento = documento;
        this.nombres = nombres;
        this.apellidos = apellidos;
        this.fechaIngreso = fechaIngreso;
        this.horaIngreso = horaIngreso;
    }

    public String getDocumento() {
        return documento;
    }

    public void setDocumento(String documento) {
        this.documento = documento;
    }

    public String getNombres() {
        return nombres;
    }

    public void setNombres(String nombres) {
        this.nombres = nombres;
    }

    public String getApellidos() {
        return apellidos;
    }

    public void setApellidos(String apellidos) {
        this.apellidos = apellidos;
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