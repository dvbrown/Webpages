<script>

function calculate() {
var RNA_per_rxn = document.getElementById("RNA_per_rxn");
var dilution = document.getElementById("dilution");
var total_RNA = document.getElementById("total_RNA");

var dilution = Number(total_RNA) * Number(RNA_per_rxn);
return dilution;
}
</script>
