//------------------------------------------------------------------------------
// <auto-generated>
//     Este código se generó a partir de una plantilla.
//
//     Los cambios manuales en este archivo pueden causar un comportamiento inesperado de la aplicación.
//     Los cambios manuales en este archivo se sobrescribirán si se regenera el código.
// </auto-generated>
//------------------------------------------------------------------------------

namespace VeterinariaApp.Models
{
    using System;
    using System.Collections.Generic;
    using System.Web.Mvc;

    public partial class tbl_mascotas
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public tbl_mascotas()
        {
            this.tbl_factura = new HashSet<tbl_factura>();
        }
    
        public string id_m { get; set; }
        public string nombre_m { get; set; }
        public string descripcion_m { get; set; }
        public string edad_m { get; set; }
        public string sexo_m { get; set; }
        public System.DateTime fecha_nacimiento_m { get; set; }
        public string codigo_e { get; set; }
        public string id_c { get; set; }
        public string codigo_r { get; set; }
    
        public virtual tbl_cliente tbl_cliente { get; set; }
        public virtual tbl_especie tbl_especie { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tbl_factura> tbl_factura { get; set; }
        public virtual tbl_raza tbl_raza { get; set; }
    }
}
