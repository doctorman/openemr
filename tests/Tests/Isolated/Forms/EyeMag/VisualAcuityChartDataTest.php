<?php

/**
 * Regression coverage for Eye Mag visual-acuity Chart.js data generation.
 *
 * display_VisualAcuities() must pass PHP arrays through js_escape() directly.
 * Imploding the arrays first turns them into quoted strings and produces
 * invalid JavaScript when multiple visit dates are present.
 *
 * @package   OpenEMR
 * @link      https://www.open-emr.org
 * @author    OpenEMR Contributors
 * @copyright Copyright (c) 2026 OpenEMR Contributors
 * @license   https://github.com/openemr/openemr/blob/master/LICENSE GNU General Public License 3
 */

declare(strict_types=1);

namespace OpenEMR\Tests\Isolated\Forms\EyeMag;

use PHPUnit\Framework\Attributes\Group;
use PHPUnit\Framework\Attributes\Test;
use PHPUnit\Framework\TestCase;

#[Group('isolated')]
class VisualAcuityChartDataTest extends TestCase
{
    private string $source;

    protected function setUp(): void
    {
        $path = dirname(__DIR__, 5) . '/interface/forms/eye_mag/php/eye_mag_functions.php';
        $source = file_get_contents($path);
        $this->assertNotFalse($source, "Could not read {$path}");
        $this->source = $source;
    }

    #[Test]
    public function visualAcuityChartKeepsStructuredArrays(): void
    {
        $this->assertStringContainsString('$VA_dates = $array_va_dates;', $this->source);
        $this->assertStringContainsString('$VA_SCODVA = $array_va_SCODVA;', $this->source);
        $this->assertStringContainsString('$VA_CTLOSVA = $array_va_CTLOSVA;', $this->source);
        $this->assertStringNotContainsString('$VA_dates = implode(', $this->source);
    }

    #[Test]
    public function chartLabelsAreNotWrappedInAnExtraJavascriptString(): void
    {
        $this->assertStringContainsString(
            'labels: <?php echo js_escape($VA_dates); ?>,',
            $this->source
        );
        $this->assertStringNotContainsString(
            "labels: '<?php echo js_escape(\$VA_dates); ?>',",
            $this->source
        );
    }
}
